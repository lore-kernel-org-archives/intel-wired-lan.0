From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 11 Mar 2020 16:50:57 -0700
Subject: [Intel-wired-lan] [PATCH 7/8] ice: add basic handler for
 devlink .info_get
In-Reply-To: <20200311213319.783841-8-jacob.e.keller@intel.com>
References: <20200311213319.783841-1-jacob.e.keller@intel.com>
 <20200311213319.783841-8-jacob.e.keller@intel.com>
Message-ID: <20200311165057.3f69e090@kicinski-fedora-PC1C0HJN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 11 Mar 2020 14:33:18 -0700 Jacob Keller wrote:
> +    * - ``fw.bundle``
> +      - running
> +      - 0x80002ec0
> +      - Unique identifier of the firmware image file that was loaded onto
> +        the device. Also referred to as the EETRACK identifier of the NVM.

Ugh, I think I mislead you in the previous discussion..

Could you s/fw.bundle/fw.bundle_id/ and make it generic? NFP has the
"_id" at the end which I clearly forgot about..
