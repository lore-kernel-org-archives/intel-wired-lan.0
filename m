From: Nelson, Shannon <shannon.nelson@intel.com>
Date: Wed, 13 Jan 2016 18:02:44 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] i40e: use
	eth_platform_get_mac_address()
In-Reply-To: <2da591718f08ebe8285b6bf9376893ec73ac98bb.1452655484.git.sowmini.varadhan@oracle.com>
References: <cover.1452655483.git.sowmini.varadhan@oracle.com>
 <2da591718f08ebe8285b6bf9376893ec73ac98bb.1452655484.git.sowmini.varadhan@oracle.com>
Message-ID: <FC41C24E35F18A40888AACA1A36F3E418AFE4BE2@fmsmsx115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Sowmini Varadhan [mailto:sowmini.varadhan at oracle.com]
> 
> This commit converts commit b499ffb0a22c ("i40e: Look up MAC address in
> Open Firmware or IDPROM") to use eth_platform_get_mac_address()
> added by commit c7f5d105495a ("net: Add eth_platform_get_mac_address()
> helper.")
> 
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   19 +------------------
>  1 files changed, 1 insertions(+), 18 deletions(-)

Much nicer - thanks Dave and Sowmini!
sln

