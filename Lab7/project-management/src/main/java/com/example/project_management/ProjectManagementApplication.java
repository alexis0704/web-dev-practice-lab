package com.example.project_management;

import java.util.List;

import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import com.example.project_management.entity.Product;
import com.example.project_management.repository.ProductRepository;

@SpringBootApplication
public class ProjectManagementApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProjectManagementApplication.class, args);
	}

	@Bean
	CommandLineRunner test(ProductRepository repository) {
		return args -> {
			System.out.println("=== Testing Repository ===");

			// Count all products
			long count = repository.count();
			System.out.println("Total products: " + count);

			// Find all products
			List<Product> products = repository.findAll();
			products.forEach(System.out::println);

			// Find by category
			List<Product> electronics = repository.findByCategory("Electronics");
			System.out.println("\nElectronics: " + electronics.size());

			System.out.println("=== Test Complete ===");
		};
	}
}
