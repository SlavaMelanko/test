
#include <catch/catch.hpp>

#include <smela/User.h>

TEST_CASE("Default User Test")
{
	sml::User defaultUser;

	REQUIRE(defaultUser.getUsername() == "user");
	REQUIRE(defaultUser.getPassword() == "user");
}

TEST_CASE("User Test")
{
	sml::User user{ "admin", "qwerty" };

	SECTION("Check getters")
	{
		REQUIRE(user.getUsername() == "admin");
		REQUIRE(user.getPassword() == "qwerty");
	}
	SECTION("Check setters")
	{
		const std::string username = "superuser";
		const std::string password = "qwerty123";

		user.setUsername(username);
		user.setPassword(password);

		REQUIRE(user.getUsername() == username);
		REQUIRE(user.getPassword() == password);
	}
}
