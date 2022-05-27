From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri, 27 May 2022 09:31:42 -0700
Subject: [Intel-wired-lan] [PATCH net] ice: disable stripping in default
 VSI ctx
In-Reply-To: <20220527115131.7413-1-marcin.szycik@linux.intel.com>
References: <20220527115131.7413-1-marcin.szycik@linux.intel.com>
Message-ID: <8fd71e27-7f9a-fab8-62c5-b16839b882f5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 5/27/2022 4:51 AM, Marcin Szycik wrote:

This fixes commit doesn't exist in net, so it shouldn't be targeting 
net. It looks like the patch this is fixing is still on Intel Wired LAN 
[1]. Perhaps it would be better to squash it with that patch as a v2?

> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> In case when driver is in eswitch mode, having VLAN stripping enabled
> causes failure in communication. All VLAN configuration commands are
> blocked, because of that VF driver can't disable VLAN stripping at
> initialization. It leads to the situation when VLAN stripping on VF VSI
> is on, but in kernel it is off.
> 
> To prevent this, set VLAN stripping to disabled in VSI initialization.
> It doesn't break other usecases, because it is set according to kernel
> settings.
> 
> Fixes: f09901aa554a ("ice: remove VLAN representor specific ops")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

[1] 
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20220425062756.14987-3-michal.swiatkowski at linux.intel.com/
