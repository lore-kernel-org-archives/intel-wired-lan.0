From: Chris Friesen <chris.friesen@windriver.com>
Date: Mon, 1 Feb 2016 09:05:47 -0600
Subject: [Intel-wired-lan] anyone aware of problem with 82599ES stuck
 sending TX pause frames?
In-Reply-To: <F6FB0E698C9B3143BDF729DF2228664691E709B9@ORSMSX116.amr.corp.intel.com>
References: <56AA60A1.7060408@windriver.com>
 <F6FB0E698C9B3143BDF729DF2228664691E709B9@ORSMSX116.amr.corp.intel.com>
Message-ID: <56AF744B.1000403@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 01/28/2016 01:13 PM, Skidmore, Donald C wrote:
> Hey Chris,
>
> I've seen issues that seemed similar to this caused by a switches not playing
> well with the NIC.  Are you going through a switch and if so could you see if
> you can recreate back to back with a different switch?

Got some more information on this from one of our guys.  Here's what he says:


"This has been seen at least 3 times recently... on 3 different switches (1 of 
which is a Cisco Nexus 5K).  I would be willing to believe that our Quanta 
switches did something suspect, but not the Cisco.   I also find it hard to 
believe that something the switch could do would cause the device to send out 
pause frames.  As far as I understand it is only supposed to do that in response 
to running out of rx buffers while receiving packets.  It is then supposed to 
send XON frames once more rx buffers are available.

I checked the switch ports connected to both systems that were affected today. 
Neither of them have flow control enabled which means this was the Intel device 
doing something suspect all on its own."



I'll see about trying the out-of-tree driver, but without a straightforward way 
to reproduce it'll be hard to tell if it fixes things.

Chris
