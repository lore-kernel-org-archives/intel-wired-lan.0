From: Mateusz Palczewski <mateusz.palczewski@intel.com>
Date: Mon, 13 Dec 2021 13:12:48 +0100
Subject: [Intel-wired-lan] [PATCH net-next v1 0/2] i40e: Hw tc offload and
 hw tc offload settings
Message-ID: <20211213121248.4137-1-mateusz.palczewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Patch series created to change the behaviour of driver related to hw-tc-offload and changing ntuple setting.

Mateusz Palczewski (2):
  i40e: Disable hw-tc-offload feature on driver load
  i40e: Fix ntuple setting change

 drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.27.0

