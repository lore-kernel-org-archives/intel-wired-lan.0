From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 12 Mar 2020 13:18:36 -0700
Subject: [Intel-wired-lan] [PATCH v3 8/9] ice: add basic handler for
 devlink .info_get
In-Reply-To: <20200312015818.1007882-9-jacob.e.keller@intel.com>
References: <20200312015818.1007882-1-jacob.e.keller@intel.com>
 <20200312015818.1007882-9-jacob.e.keller@intel.com>
Message-ID: <20200312131836.1679a4a3@kicinski-fedora-PC1C0HJN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 11 Mar 2020 18:58:17 -0700 Jacob Keller wrote:
> The devlink .info_get callback allows the driver to report detailed
> version information. The following devlink versions are reported with
> this initial implementation:
> 
>  "fw.mgmt" -> The version of the firmware that controls PHY, link, etc
>  "fw.mgmt.api" -> API version of interface exposed over the AdminQ
>  "fw.mgmt.build" -> Unique build id of the source for the management fw
>  "fw.undi" -> Version of the Option ROM containing the UEFI driver
>  "fw.psid.api" -> Version of the NVM image format.
>  "fw.bundle_id" -> Unique identifier for the combined flash image.
>  "fw.app.name" -> The name of the active DDP package.
>  "fw.app" -> The version of the active DDP package.

Acked-by: Jakub Kicinski <kuba@kernel.org>
