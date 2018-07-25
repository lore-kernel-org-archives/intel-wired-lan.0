From: Luciano Coelho <luciano.coelho@intel.com>
Date: Wed, 25 Jul 2018 23:59:23 +0300
Subject: [Intel-wired-lan] [PATCH v1 3/4] iwlwifi: Remove unnecessary
 include of <linux/pci-aspm.h>
In-Reply-To: <153254836793.92573.16383045269302376209.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153254836793.92573.16383045269302376209.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <285792564f164b40609f696616ff0169c46ceb8c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-07-25 at 14:52 -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This part of the iwlwifi driver doesn't need anything provided by
> pci-aspm.h, so remove the unnecessary include of it.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Acked-by: Luca Coelho <luciano.coelho@intel.com>

Thanks!

--
Cheers,
Luca.
