From: Guilherme Piccoli <gpiccoli@canonical.com>
Date: Wed, 19 Jun 2019 14:41:39 -0300
Subject: [Intel-wired-lan] [net] ixgbevf: Use cached link state instead
 of re-reading the value for ethtool
In-Reply-To: <20190619165853.28234-1-jeffrey.t.kirsher@intel.com>
References: <20190619165853.28234-1-jeffrey.t.kirsher@intel.com>
Message-ID: <CAHD1Q_x2dYwinfeXgJdoCD_d7g=Yj-G7KZebuEX5_Kfh4fnqRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jun 19, 2019 at 1:58 PM Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> Change the ethtool link settings call to just read the cached state out of
> the adapter structure instead of trying to recheck the value from the PF.
> Doing this should prevent excessive reading of the mailbox.
>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Reviewed-by: Guilherme Piccoli <gpiccoli@canonical.com>

[+ Jay Vosburgh]

Thanks Jeff! A minor nit: if possible can you change my name <for consistency>
before merging?
s/Guilherme Piccoli/Guilherme G. Piccoli

Otherwise looks fine to me!
Cheers,


Guilherme
