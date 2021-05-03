From: Nick Lowe <nick.lowe@gmail.com>
Date: Mon, 3 May 2021 20:53:48 +0100
Subject: [Intel-wired-lan] Stable inclusion request - igb: Enable RSS for
 Intel I211 Ethernet Controller
In-Reply-To: <20210503113010.774e4ca6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201221222502.1706-1-nick.lowe@gmail.com>
 <379d4ef3-02e5-f08a-1b04-21848e11a365@bluematt.me>
 <20210201084747.2cb64c3f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <a7a89e90bf6c3f383fa236b1128db8d012223da0.camel@intel.com>
 <20210201114545.6278ae5c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <69e92a09-d597-2385-2391-fee100464c59@bluematt.me>
 <CADSoG1vn-T3ZL0uZSR-=TnGDdcqYDXjuAxqPaHb0HjKYSuQwXg@mail.gmail.com>
 <20210201123350.159feabd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CADSoG1sf9zXj9CQfJ3kQ1_CUapmZDa6ZeKtbspUsm34c7TSKqw@mail.gmail.com>
 <20210503113010.774e4ca6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <CADSoG1stdPVOE2N0dg10T6tgTUN1nqafY_m+K1CLwB6z2Y9j5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

Please may we request that commit 6e6026f2dd20 ("igb: Enable RSS for
Intel I211 Ethernet Controller") be backported to the 5.4 and 5.10 LTS
kernels?

The Intel i211 Ethernet Controller supports 2 Receive Side Scaling
(RSS) queues, the patch corrects the issue that the i211 should not be
excluded from having this feature enabled.

Best regards,

Nick

---------- Forwarded message ---------
From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 3 May 2021 at 19:30
Subject: Re: [PATCH net] igb: Enable RSS for Intel I211 Ethernet Controller
To: Nick Lowe <nick.lowe@gmail.com>
Cc: Matt Corallo <linux-wired-list@bluematt.me>, Nguyen, Anthony L
<anthony.l.nguyen@intel.com>, netdev at vger.kernel.org
<netdev@vger.kernel.org>, davem at davemloft.net <davem@davemloft.net>,
Brandeburg, Jesse <jesse.brandeburg@intel.com>,
intel-wired-lan at lists.osuosl.org <intel-wired-lan@lists.osuosl.org>


On Mon, 3 May 2021 13:32:24 +0100 Nick Lowe wrote:
> Hi all,
>
> Now that the 5.12 kernel has released, please may we consider
> backporting commit 6e6026f2dd2005844fb35c3911e8083c09952c6c to both
> the 5.4 and 5.10 LTS kernels so that RSS starts to function with the
> i211?

No objections here. Please submit the backport request to stable at .
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-2
