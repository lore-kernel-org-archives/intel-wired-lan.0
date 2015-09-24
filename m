From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 24 Sep 2015 15:44:29 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: Fix basic support for X722
 devices
In-Reply-To: <1443133592-159225-1-git-send-email-anjali.singhai@intel.com>
References: <1443133592-159225-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <20150924154429.00003d3e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 24 Sep 2015 15:26:32 -0700
Anjali Singhai Jain <anjali.singhai@intel.com> wrote:

> Acquire NVM, before issuing an AQ read nvm command for X722.
> We need to acquire the NVM before issuing an AQ read to the NVM
> otherwise we will get EBUSY from the FW. Also release when done.
> 
> This fixes the two X722 issues with respect to eeprom checksum verify
> and reading NVM version info.
> 
> With this patch in place, i40e driver will provide basic support
> for X722 devices.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>

We sent this patch upstream out of sequence in order to correctly
enable X722, as without it the driver will fail to load on those
parts when they arrive in customer's hands. 

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

