From: Aaron Sierra <asierra@xes-inc.com>
Date: Wed, 12 Oct 2016 15:19:19 -0500 (CDT)
Subject: [Intel-wired-lan] Bug with 'igb: Remove GS40G specific
	defines/functions'
In-Reply-To: <77C85CBC-39FD-40B4-9456-56A3FEE3544A@vectranetworks.com>
References: <77C85CBC-39FD-40B4-9456-56A3FEE3544A@vectranetworks.com>
Message-ID: <1570773976.567827.1476303559656.JavaMail.zimbra@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Chris,
Someone else reported a similar issue back in April. Would you
mind taking a look at the discussion that we had back then to
see if it applies to you?

http://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20160425/005171.html

-- 
--- Extreme Engineering Solutions, Inc (X-ES) ---
Aaron Sierra
Senior Embedded Engineer
X-ES http://www.xes-inc.com
3225 Deming Way, Ste 120
Middleton, WI  53562
Phone: (608) 833-1155 x115
Email: asierra at xes-inc.com

----- Original Message -----
> From: "Chris Arges" <carges@vectranetworks.com>
> To: "Aaron Sierra" <asierra@xes-inc.com>, "jeffrey t kirsher" <jeffrey.t.kirsher@intel.com>
> Cc: "intel-wired-lan" <intel-wired-lan@lists.osuosl.org>
> Sent: Wednesday, October 12, 2016 2:51:41 PM
> Subject: Bug with 'igb: Remove GS40G specific defines/functions'

> Hi,
> 
> I have an Intel I210 NIC which shows:
> 'igb: probe of 0000:07:00.0 failed wtih error -2'
> Upon boot after power has been completely disconnected.
> 
> v4.4 works, while v4.5 fails and I was able to bisect it down to:
> commit 2a3cdead8b408351fa1e3079b220fa331480ffbc
> 
> Any ideas for a fix? I'm happy to test any patches.
> 
> (apologies for the resend, typed the wrong address.)
> 
> --chris
