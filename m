From: Cristian Dumitrescu <cristian.dumitrescu@intel.com>
Date: Thu, 14 Jan 2021 14:33:14 +0000
Subject: [Intel-wired-lan] [PATCH net-next 0/4] i40e: small improvements on
 XDP path
Message-ID: <20210114143318.2171-1-cristian.dumitrescu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patchset introduces some small and straightforward improvements
to the Intel i40e driver XDP path. Each improvement is fully described
in its associated patch.

Cristian Dumitrescu (4):
  i40e: remove unnecessary memory writes of the next to clean pointer
  i40e: remove unnecessary cleaned_count updates
  i40e: remove the redundant buffer info updates
  i40: consolidate handling of XDP program actions

 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 149 +++++++++++----------
 1 file changed, 79 insertions(+), 70 deletions(-)

-- 
2.25.1

