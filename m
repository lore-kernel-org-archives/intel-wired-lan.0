From: Owen Wells <owen.wells@adiengineering.com>
Date: Wed, 2 Dec 2015 09:57:59 -0500
Subject: [Intel-wired-lan] IGB driver load resets NC-SI interface on
	Rangeley C2000
Message-ID: <002501d12d11$d5c1b1f0$814515d0$@adiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

 

I was referred to this email address by Juan Nu?ez Quesada, the application
support engineer assigned to our IPS case. 

 

We have a BMC connected to Rangeley (Atom C2000) via the NC-SI interface. We
are able to get to the LAN to/from the BMC, so that works. The issue is that
while Linux is booting, the IGB driver loads and resets the NC-SI interface,
causing us to lose connection with the BMC. We can reconnect after the
reset, but that is not acceptable to the customer
. They need a solid
connection.

 

We would like to understand how and why the IGB driver is resetting the
NC-SI interface. That technically should not happen
 the NC-SI interface
should be up at all times so that the BMC can stay on the network even when
Rangeley is shut down.

 

As an experiment, I did try modifying some EEPROM settings to prevent the
IGB driver from resetting the interface. Specifically, I cleared bit 0 of
the Initialization Control 4 word in the EEPROM (LAN base address + Offset
0x13) to disable software reset. This does not appear to have an effect.

 

Please assist. Thanks!

 

 

Owen Wells

Senior Staff Hardware Engineer

ADI Engineering, A Division of Silicom

Cell +1-434-760-0289

Skype owen.wells

owen.wells at adiengineering.com

www.adiengineering.com <http://www.adiengineering.com/> 

 

 

 

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151202/be107484/attachment-0001.html>
