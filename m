From: David Miller <davem@davemloft.net>
Date: Wed, 12 Jul 2017 14:37:57 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH] igb: fix unused
 igb_deliver_wake_packet() warning when CONFIG_PM=n
In-Reply-To: <20170712210925.4F647FAA@viggo.jf.intel.com>
References: <20170712210925.4F647FAA@viggo.jf.intel.com>
Message-ID: <20170712.143757.39770380256592298.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 12 Jul 2017 14:09:25 -0700

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> I'm seeing warnings on kernel configurations where CONFIG_PM is
> disabled.  It happens in 4.12, at least:
> 
> drivers/ethernet/intel/igb/igb_main.c:7988:13: warning: 'igb_deliver_wake_packet' defined but not used [-Wunused-function]
> 
> This is because igb_deliver_wake_packet() is defined outside of
> the #ifdef", but is used only a single time within the #ifdef in
> igb_resume().  Fix it by moving igb_deliver_wake_packet() next to
> igb_resume() inside the #ifdef.
> 
> The diff ends up looking a bit funky here.  It *looks* like
> igb_suspend() is getting moved, but that's an artifact of how
> 'diff' sees the changes.
> 
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>

I'll let Jeff queue this up into his tree.
