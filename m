From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 12 Mar 2020 13:18:59 -0700
Subject: [Intel-wired-lan] [PATCH v3 9/9] ice: add board identifier info
 to devlink .info_get
In-Reply-To: <20200312015818.1007882-10-jacob.e.keller@intel.com>
References: <20200312015818.1007882-1-jacob.e.keller@intel.com>
 <20200312015818.1007882-10-jacob.e.keller@intel.com>
Message-ID: <20200312131859.49068276@kicinski-fedora-PC1C0HJN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 11 Mar 2020 18:58:18 -0700 Jacob Keller wrote:
> Export a unique board identifier using "board.id" for devlink's
> .info_get command.
> 
> Obtain this by reading the NVM for the PBA identification string.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>
