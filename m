From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 13 Dec 2021 20:19:53 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 0/2] i40e: Hw tc offload
 and hw tc offload settings
In-Reply-To: <20211213121248.4137-1-mateusz.palczewski@intel.com>
References: <20211213121248.4137-1-mateusz.palczewski@intel.com>
Message-ID: <4a1340d6941d7c1b3653eb29a934570a1197a7ac.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-12-13 at 13:12 +0100, Mateusz Palczewski wrote:
> Patch series created to change the behaviour of driver related to hw-
> tc-offload and changing ntuple setting.
> 
> Mateusz Palczewski (2):
> ? i40e: Disable hw-tc-offload feature on driver load
> ? i40e: Fix ntuple setting change
> 
> ?drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++++-
> ?1 file changed, 4 insertions(+), 1 deletion(-)

This seems better suited as one patch since the second patch is fixing
an issue caused by the first.
