From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 23 May 2018 18:46:16 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix possible race in the
 reset subtask
In-Reply-To: <20180522161846.2844.21726.stgit@localhost6.localdomain6>
References: <20180522161846.2844.21726.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B771F3D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Tuesday, May 22, 2018 9:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: fix possible race in the reset
> subtask
> 
> Extend the RTNL lock in ixgbevf_reset_subtask() to protect the state bits
> check in addition to the call to ixgbevf_reinit_locked().
> 
> This is to make sure that we get the most up-to-date values for the bits and
> avoid a possible race when going down.
> 
> Suggested-by: Zhiping du <zhipingdu@tencent.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


