package com.salesianos.socialrides.service;

import com.salesianos.socialrides.exception.post.NoPostsException;
import com.salesianos.socialrides.exception.user.NotLikedPostsException;
import com.salesianos.socialrides.exception.user.UserNotFoundException;
import com.salesianos.socialrides.model.page.dto.PageResponse;
import com.salesianos.socialrides.model.post.Post;
import com.salesianos.socialrides.model.post.dto.PostResponse;
import com.salesianos.socialrides.model.user.User;
import com.salesianos.socialrides.model.user.UserRole;
import com.salesianos.socialrides.model.user.dto.*;
import com.salesianos.socialrides.repository.UserRepository;
import com.salesianos.socialrides.search.spec.GenericSpecificationBuilder;
import com.salesianos.socialrides.search.util.SearchCriteria;
import com.salesianos.socialrides.search.util.SearchCriteriaExtractor;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.EnumSet;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class UserService {

    private final PasswordEncoder passwordEncoder;

    private final UserRepository userRepository;
    private final StorageService storageService;

    public Optional<User> findById(UUID id){return userRepository.findById(id);}

    public User save(User user){return userRepository.save(user);}

    public Optional<User> findByUsername(String username){
        return userRepository.findFirstByUsernameIgnoreCase(username);
    }

    public UserResponse findUserByUsername(String username){
        return userRepository.findFirstByUsername(username)
                .map(UserResponse::of)
                .orElseThrow(() -> new UserNotFoundException(username));
    }

    public User createUser(CreateUserRequest createUserRequest, MultipartFile file, EnumSet<UserRole> roles){

        String filename = storageService.store(file);

        User user = User.builder()
                .username(createUserRequest.getUsername())
                .password(passwordEncoder.encode(createUserRequest.getPassword()))
                .avatar(filename)
                .name(createUserRequest.getName())
                .surname(createUserRequest.getSurname())
                .email(createUserRequest.getEmail())
                .birthday(createUserRequest.getBirthday())
                .roles(roles)
                .build();

        return userRepository.save(user);
    }

    public User createUserWithUserRole(CreateUserRequest createUserRequest, MultipartFile file){
        return createUser(createUserRequest, file, EnumSet.of(UserRole.USER));
    }

    public User createUserWithAdminRole(CreateUserRequest createUserRequest, MultipartFile file){
        return createUser(createUserRequest, file, EnumSet.of(UserRole.ADMIN));
    }

    public Optional<User> editPassword(UUID userId, String newPassword){
        return userRepository.findById(userId)
                .map( user -> {
                    user.setPassword(passwordEncoder.encode((newPassword)));
                    return userRepository.save(user);
                }).or(Optional::empty);
    }

    public UserResponse edit(EditUserRequest editedUser, MultipartFile file, User user) {

        String filename = storageService.store(file);

        return UserResponse.toDetails(userRepository.findById(user.getId())
                .map(u -> {
                    u.setAvatar(filename);
                    u.setName(editedUser.getName());
                    u.setSurname(editedUser.getSurname());
                    u.setEmail(editedUser.getEmail());
                    u.setBirthday(editedUser.getBirthday());
                    return userRepository.save(u);
                }).orElseThrow(UserNotFoundException::new));
    }

    public boolean passwordMatch(User user, String password){
        return passwordEncoder.matches(password, user.getPassword());
    }

    public void delete(User user){ deleteById(user.getId());}

    public void deleteById(UUID id){
        //TODO - CUANDO SE IMPLEMENTE ACORDARSE DE BORRAR LA IMAGEN
        if(userRepository.existsById(id))
            userRepository.deleteById(id);
    }

    public boolean existsByUsername(String username){
        return userRepository.existsByUsernameIgnoreCase(username);
    }

    public ExistsUserResponse existsUsername(String username){
        return ExistsUserResponse.of(existsByUsername(username));
    }

    public boolean existsByEmail(String email){ return userRepository.existsByEmailIgnoreCase(email); }

    public PageResponse<List<PostResponse>> getLikedPosts(Pageable pageable, UUID userId){

        PageResponse<List<PostResponse>> users = new PageResponse<>(userRepository.findLikedPosts(pageable, userId));

        if(users.getContent().isEmpty())
            throw new NotLikedPostsException();
        return users;
    }

    public PageResponse<List<PostResponse>> getLikedPostsByUsername(Pageable pageable, String username){
        User user = userRepository.findByUsername(username)
                .orElseThrow(()-> new UserNotFoundException(username));
        return getLikedPosts(pageable, user.getId());
    }

    public UserResponse getProfile(UUID id){
        return UserResponse.of(
                userRepository.findById(id)
                        .orElseThrow(UserNotFoundException::new)
        );
    }

    public PageResponse<UserResponse> searchUsers(Pageable pageable, String searchQuery){
        List<SearchCriteria> searchCriteria = SearchCriteriaExtractor.extractSearchCriteriaList(searchQuery);
        Specification<User> spec = (new GenericSpecificationBuilder<User>(searchCriteria, User.class)).build();
        if(spec != null){
            Page<UserResponse> page = userRepository.findAll(spec, pageable).map(UserResponse::toList);
            return new PageResponse<>(page);
        }
        return new PageResponse<>(userRepository.findAll(pageable).map(UserResponse::toList));
    }

    // *********************** ADMIN METHODS *********************************

    public PageResponse<UserResponse> getUsersAdmin(Pageable pageable, String search){
        List<SearchCriteria> searchCriteria = SearchCriteriaExtractor.extractSearchCriteriaList(search);
        Specification<User> spec = (new GenericSpecificationBuilder<User>(searchCriteria, User.class)).build();
        if(spec != null){
            Page<UserResponse> page = userRepository.findAll(spec, pageable).map(UserResponse::toListAdmin);
            return new PageResponse<>(page);
        }
        return new PageResponse<>(userRepository.findAll(pageable).map(UserResponse::toListAdmin));
    }

    public void banUser(String username){
        User user = userRepository.findByUsername(username).orElseThrow(()-> new UserNotFoundException(username));
        user.setEnabled(false);
        userRepository.save(user);
    }

    public void unBanUser(String username){
        User user = userRepository.findByUsername(username).orElseThrow(()-> new UserNotFoundException(username));
        user.setEnabled(true);
        userRepository.save(user);
    }

    @Transactional
    public UserResponse editRole(EditRoleRequest editRole, String username) {

        User u = userRepository.findByUsername(username).orElseThrow(()->new UserNotFoundException(username));
        User user = userRepository.findById(u.getId()).get();
        user.setRoles(editRole.getRoles());
        return UserResponse.toDetails(userRepository.save(user));
    }
}
