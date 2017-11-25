
#include "smela/User.h"

namespace sml
{

User::User(const std::string& username, const std::string& password)
	: _username{ username }
	, _password{ password }
{
}

} // namespace sml
