
#pragma once

#include <string>

namespace sml
{

class User
{
public:
	User() = default;
	User(const std::string& username, const std::string& password);

	std::string getUsername() const;
	std::string getPassword() const;

	void setUsername(std::string username);
	void setPassword(std::string password);

private:
	std::string _username = "user";
	std::string _password = "user";
};

inline std::string User::getUsername() const
{
	return _username;
}

inline std::string User::getPassword() const
{
	return _password;
}

inline void User::setUsername(std::string username)
{
	_username = std::move(username);
}

inline void User::setPassword(std::string password)
{
	_password = std::move(password);
}

} // namespace sml
