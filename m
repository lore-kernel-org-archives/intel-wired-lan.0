From: Chris Friesen <chris.friesen@windriver.com>
Date: Thu, 28 Jan 2016 13:50:00 -0600
Subject: [Intel-wired-lan] anyone aware of problem with 82599ES stuck
 sending TX pause frames?
In-Reply-To: <F6FB0E698C9B3143BDF729DF2228664691E709B9@ORSMSX116.amr.corp.intel.com>
References: <56AA60A1.7060408@windriver.com>
 <F6FB0E698C9B3143BDF729DF2228664691E709B9@ORSMSX116.amr.corp.intel.com>
Message-ID: <56AA70E8.3070302@windriver.com>
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

Yes, we're going through a switch.  It's been pretty intermittent, so 
reproducing on demand is difficult.

> Likewise it might be interesting to try the OoT driver, just to see if a
> later fix addressed what you're seeing.  I can't think of anything off the
> top of my head, but trying the newer driver might help identify if we have.

Right, I'll bring it up.

> Also are you seeing anything interesting on the system log?

No, pretty boring.

Chris
