From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Fri, 16 Mar 2018 09:21:16 -0700
Subject: [Intel-wired-lan] [PATCH v2 03/15] ice: Start hardware
 initialization
In-Reply-To: <20180315234802.31336-4-anirudh.venkataramanan@intel.com>
References: <20180315234802.31336-1-anirudh.venkataramanan@intel.com>
 <20180315234802.31336-4-anirudh.venkataramanan@intel.com>
Message-ID: <e39c8a7c-a6ad-3414-fec9-31540b65b010@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/15/2018 4:47 PM, Anirudh Venkataramanan wrote:
> This patch implements multiple pieces of the initialization flow
> as follows:
> 
> 1) A reset is issued to ensure a clean device state, followed
>     by initialization of admin queue interface.
> 
> 2) Once the admin queue interface is up, clear the PF config
>     and transition the device to non-PXE mode.
> 
> 3) Get the NVM configuration stored in the device's non-volatile
>     memory (NVM) using ice_init_nvm.
> 
> CC: Shannon Nelson <shannon.nelson@oracle.com>
> Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> ---
> v2: Addressed Shannon Nelson's review comments by
>      1) removing an unnecessary register write in ice_aq_clear_pxe_mode.
>      2) adding a comment explaining the need to convert word sized values
>         to byte sized values.

These two changes look fine.

sln

Acked-by: Shannon Nelson <shannon.nelson@oracle.com>

