From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 14 Jan 2016 03:15:41 +0000
Subject: [Intel-wired-lan] [next PATCH 09/11] igb: Drop unnecessary
 checks	in transmit path
In-Reply-To: <20160107071126.13648.59051.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>,
 <20160107071126.13648.59051.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E4F1A2@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Alexander Duyck [aduyck at mirantis.com]
> Sent: Wednesday, January 06, 2016 11:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 09/11] igb: Drop unnecessary checks      in transmit path
> 
> This patch drops several checks that we dropped from ixgbe some ago.  It
> should not be possible for us to be called with either of the conditional
> statements returning true so we can just drop them from the hot-path.
>
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |   10 ----------
>  1 file changed, 10 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
