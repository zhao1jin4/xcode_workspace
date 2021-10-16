#import "BankAccount.h"
#import "BankCustomer.h"
int main_kvo (int argc, const char *argv[])
{
	BankAccount *account=[[BankAccount alloc]init];
	BankCustomer *customer =[[BankCustomer alloc]init];
	[customer setAccount:account];
	[customer myRegstierMonitor];
	[account begainTimer];
	[[NSRunLoop 	currentRunLoop]run];
	return 1;
}