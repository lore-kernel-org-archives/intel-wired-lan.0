From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 19 Oct 2017 13:44:09 -0700
Subject: [Intel-wired-lan] [PATCH RFC V1 net-next 0/6] Time based packet
	transmission
In-Reply-To: <743a4550-7344-5e73-bf6d-6ec368263ad9@intel.com>
References: <cover.1505719061.git.rcochran@linutronix.de>
 <743a4550-7344-5e73-bf6d-6ec368263ad9@intel.com>
Message-ID: <20171019204409.vmkhii2vocum43l6@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 18, 2017 at 03:18:55PM -0700, Jesus Sanchez-Palencia wrote:
> This is great. Just out of curiosity, were you using vlans on your tests?

No, just raw packets.  VLAN tags could be added trivially (in the
program), but that naturally avoids the kernel's VLAN code.

> I might try to reproduce them soon. I would appreciate if you could provide me
> with the scripts, please.

Ok, will do.

Thanks,
Richard
