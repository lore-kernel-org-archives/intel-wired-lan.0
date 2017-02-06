From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:37 -0800
Subject: [Intel-wired-lan] [FIXUP PATCH 0/2] fixup patches for warnings in
	queue
Message-ID: <20170206223840.30938-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The following two patches are fixup/squash patches that should be rolled
into the relevant patches on the queue, to resolve some compile warnings
found while working on the flexible byte ntuple ethtool interface.

Please do not send these directly. If the relevant patch was already
merged, let me know so I can roll them as proper fixes. Otherwise,
please ensure these fixes land in the original work before it is pulled.

Jacob Keller (2):
  fixup! i40e: Introduce VF Port Representator(VFPR) netdevs
  fixup! i40e: Add support for exposing VF port statistics via VFPR
    netdev on the host

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.12.0.rc0.151.g8a5726c42288

