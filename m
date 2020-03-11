From: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 11 Mar 2020 16:49:32 -0700
Subject: [Intel-wired-lan] [PATCH 8/8] ice: add board identifier info to
 devlink .info_get
In-Reply-To: <20200311213319.783841-9-jacob.e.keller@intel.com>
References: <20200311213319.783841-1-jacob.e.keller@intel.com>
 <20200311213319.783841-9-jacob.e.keller@intel.com>
Message-ID: <20200311164932.1a9def7a@kicinski-fedora-PC1C0HJN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 11 Mar 2020 14:33:19 -0700 Jacob Keller wrote:
> Export a unique board identifier using "board.id" for devlink's
> .info_get command.
> 
> Obtain this by reading the NVM for the PBA identification string.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
