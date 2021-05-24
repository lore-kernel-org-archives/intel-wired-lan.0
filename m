From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Mon, 24 May 2021 13:05:31 +0300
Subject: [Intel-wired-lan] [PATCH intel-net v2 6/6] igc: add correct
 exception tracing for XDP
In-Reply-To: <20210510093854.31652-7-magnus.karlsson@gmail.com>
References: <20210510093854.31652-1-magnus.karlsson@gmail.com>
 <20210510093854.31652-7-magnus.karlsson@gmail.com>
Message-ID: <4761eca6-5007-9898-3cab-f974af68d956@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/05/2021 12:38, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Add missing exception tracing to XDP when a number of different
> errors can occur. The support was only partial. Several errors
> where not logged which would confuse the user quite a lot not
> knowing where and why the packets disappeared.
> 
> Fixes: 73f1071c1d29 ("igc: Add support for XDP_TX action")
> Fixes: 4ff320361092 ("igc: Add support for XDP_REDIRECT action")
> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
