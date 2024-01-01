package br.nikolastrapp.recebasecurity.domain.user;

import br.nikolastrapp.recebasecurity.domain.role.RoleEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.SuperBuilder;

import javax.persistence.*;
import java.util.Set;
import java.util.UUID;

@SuperBuilder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity(name = "users")
@Table(name = "users", schema = "security")
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id", nullable = false)
    private UUID id;

    @Column(unique = true, nullable = false)
    private String email;

    @Column()
    private String password;

    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(
            name="user_role_junction",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id"),
            schema = "receba"
    )
    private Set<RoleEntity> authorities;
}