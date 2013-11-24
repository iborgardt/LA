Fix false negative ssh connection check.

Tempest usually starts the ssh connection attempts before the sshd is 
fully configured. If tempest does do an authentication attempt when the
cloud image reconfigures the sshd or sets up the public key, we
can see not handled SSHException within the timeout period.
The not handled SSHException leads to false negative connection check.

This change extends the set of the non-fatal exceptions during
connection waits to SSHException which includes already accepted
AuthenticationException family.

The RemoteClient.can_authenticate becomes obsolete, when the
test_connection_auth becomes the part of its '__init__' method.
Remove all usages of can_authenticate and the method itself.
  
test_connection_auth method is changed to exception raiser method, in order
to avoid unwanted catch-and-raise-new-exception code from the RemoteClient.
  
Remove test_can_log_into_created_server because it does not test
anything new, all the test cases which uses ssh does the same job.
  
Use similar ssh connectivity check with the test_network_basic_ops,
as with all other test cases, so using the implicit conection validation of the RemoteClient.
  
  Change-Id: Ia2599f7f2c2fdc6fcbf7ad3337d82adcc50e4d16
