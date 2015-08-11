From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 11 Aug 2015 02:01:55 +0000
Subject: [Intel-wired-lan] [PATCH V2] igb: make sure SR-IOV init uses
 the right number of queues
In-Reply-To: <20150808002714.23033.34530.stgit@htfujina-fc.jf.intel.com>
References: <20150808002714.23033.34530.stgit@htfujina-fc.jf.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81AE3578@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Todd Fujinaka
> Sent: Friday, August 07, 2015 5:28 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V2] igb: make sure SR-IOV init uses the
> right number of queues
> 
> Recent changes to igb_probe_vfs() could lead to the PF holding onto all
> of the queues. Reorder igb_probe_vfs() to be before
> gb_init_queue_configuration() and add some more error checking.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
