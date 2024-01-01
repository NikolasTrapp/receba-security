package br.nikolastrapp.recebasecurity.domain.role;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.Set;

public interface RoleRepository extends JpaRepository<RoleEntity, Long>  {

    RoleEntity findByAuthority(String authority);
}
