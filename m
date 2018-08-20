From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Mon, 20 Aug 2018 15:35:18 -0700
Subject: [Intel-wired-lan] [PATCH v5] Documentation: fm10k: Add kernel
 documentation
In-Reply-To: <20180820203745.13448-1-jeffrey.t.kirsher@intel.com>
References: <20180820203745.13448-1-jeffrey.t.kirsher@intel.com>
Message-ID: <399630d8-2bc4-fc62-96de-f322cbf88493@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 8/20/2018 1:37 PM, Jeff Kirsher wrote:
> Added the fm10k kernel documentation, which apparently was missing.
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---

[...]

> +Virtual Functions (VFs)
> +-----------------------
> +Use sysfs to enable VFs.
> +Valid Range: 0-64
> +
> +For example::
> +
> +    echo $num_vf_enabled > /sys/class/net/$dev/device/sriov_numvfsr //enable VFs

s/sriov_numvfsr/sriov_numvfs/

Cheers,
sln
