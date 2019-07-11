From: Gavin Lambert <intel@mirality.co.nz>
Date: Thu, 11 Jul 2019 18:50:54 +1200
Subject: [Intel-wired-lan] [e1000e] Linux 4.9: unable to send packets after
 link recovery with patched driver
Message-ID: <3acf459ddbbd30687cda0a79523afe04@mirality.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This might be a bit of a tricky question, but I'm not really sure where 
else to ask.  Please cc me on any replies or I might overlook them.

I'm using a system with an e1000e network driver which has been patched 
to bypass the regular Linux network stack (because it can get called 
from a Xenomai RT context, among other reasons -- although in my case 
I'm not doing that).  The complete source for the patched version of the 
code can be found here:
     
https://github.com/ribalda/ethercat/blob/master/devices/e1000e/netdev-4.9-ethercat.c
(There are some minor changes to other files, but the majority of 
changes are only to this file.  You can see just the changes at 
https://gist.github.com/uecasm/5e36a15bda6ffd53079344fc443dcc5f/revisions 
.)

It was originally based on the in-kernel e1000e driver as of Linux 
4.9.65.  (I'm not the person who originally made the patches, but I am 
the person who rebased them to kernel 4.9 and I'm the one trying to 
maintain them for newer kernel versions.  Though I'm also not the person 
who made that github repo.)

On a Debian system with kernel linux-image-4.9.0-4-rt-amd64 (4.9.65) 
installed, this works perfectly.  It also works perfectly with 
linux-image-4.9.0-8-rt-amd64 (4.9.110).

However, with kernel linux-image-4.9.0-9-rt-amd64 (4.9.168) installed 
(and no other changes to the system other than building the patched 
e1000e module against this kernel's headers), something weird happens 
when the driver is running in its alternate "ecdev" mode.

Specifically, when the module is initially loaded, it works as expected 
and can send/receive without problems.  When link is removed (by 
disconnecting the Ethernet cable), it detects this as expected.  When 
link is restored, it detects this and reports it but is then unable to 
actually send any packets.  (Note: to send packets the external code 
calls the "ndo_start_xmit" operation directly, and to receive packets it 
calls "ec_poll".  Also note that it won't receive a packet unless it 
sends one first, due to the way that the network it's connected to 
works, so I can't tell if receives work or not when sends don't work.)  
Unloading and reloading the module fixes this, even if the link is 
initially down and then reconnected after the module is reloaded.  (So 
perhaps the problem is something it does at the link-loss event?)

Occasionally, it does manage to survive one or two replugs before 
getting into the problem state.  But once there, no amount of replugging 
appears to recover it; only reloading the module.

I do know that when it's in the failure state (not actually sending 
packets), e1000_xmit_frame continues to get all the way to the bottom 
and return NETDEV_TX_OK.

Note that the e1000e code being used is still the code as shown in the 
link above, not the code as exists in Linux 4.9.168.  I did try rebasing 
the ethercat patches onto the new driver version, but this didn?t seem 
to change the behavior.

Also note that the bad behavior was observed on an I219-V and an 
I219-LM, but does not appear to happen with an 82571EB (these are the 
only devices I have handy at the moment).  The problem also doesn't 
occur when using the unpatched driver from 4.9.168 as a standard Linux 
network driver.

Obviously, something the patches are doing is causing problems, but it 
seems odd that the issue only occurs with certain hardware and with 
certain kernel versions.  Any ideas on what could be the cause and 
solution (or how to narrow it down further)?  I can easily make changes 
to the driver code; it's a lot harder to try kernel versions between the 
two above, however, but I might be able to do that too.
