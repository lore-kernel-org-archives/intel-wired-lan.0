From: Jesse Gross <jesse@nicira.com>
Date: Wed, 9 Sep 2015 14:32:37 -0700
Subject: [Intel-wired-lan] [PATCH v2 5/5] i40e: Add geneve tunnel
	offload support
In-Reply-To: <1441749356-92927-5-git-send-email-anjali.singhai@intel.com>
References: <1441749356-92927-1-git-send-email-anjali.singhai@intel.com>
 <1441749356-92927-5-git-send-email-anjali.singhai@intel.com>
Message-ID: <CAEP_g=-QsSAzRhBqdUXEA9MZ_oau4J=QjiBKx7RBZ=0hqidibw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Sep 8, 2015 at 2:55 PM, Anjali Singhai Jain
<anjali.singhai@intel.com> wrote:
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index b3a6cdf..9bbafc3 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
[...]
> -#define I40E_MAX_TUNNEL_HDR_LEN 80
> +#define I40E_MAX_TUNNEL_HDR_LEN 260

Are you sure that this value is correct for all hardware using this
driver? My understanding is that Fortville doesn't support more than
64 bytes of Geneve options (with 8 bytes of UDP header and 8 bytes of
Geneve base header making the total tunnel header 80 bytes).
