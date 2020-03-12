From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 12 Mar 2020 13:17:38 -0700
Subject: [Intel-wired-lan] [PATCH v3 7/9] devlink: promote
 "fw.bundle_id" to a generic info version
In-Reply-To: <20200312015818.1007882-8-jacob.e.keller@intel.com>
References: <20200312015818.1007882-1-jacob.e.keller@intel.com>
 <20200312015818.1007882-8-jacob.e.keller@intel.com>
Message-ID: <20200312131738.77d91d7e@kicinski-fedora-PC1C0HJN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 11 Mar 2020 18:58:16 -0700 Jacob Keller wrote:
> The nfp driver uses ``fw.bundle_id`` to represent a unique identifier of the
> entire firmware bundle.
> 
> A future change is going to introduce a similar notion in the ice
> driver, so promote ``fw.bundle_id`` into a generic version now.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
