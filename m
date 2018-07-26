From: Kalle Valo <kvalo@codeaurora.org>
Date: Thu, 26 Jul 2018 09:07:40 +0300
Subject: [Intel-wired-lan] [PATCH v1 2/4] ath9k: Remove unnecessary
 include of <linux/pci-aspm.h>
In-Reply-To: <153254835812.92573.3566522887325831923.stgit@bhelgaas-glaptop.roam.corp.google.com>
 (Bjorn Helgaas's message of "Wed, 25 Jul 2018 14:52:38 -0500")
References: <153254813164.92573.10755585465477668768.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <153254835812.92573.3566522887325831923.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <874lgmv8b7.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The ath9k driver doesn't need anything provided by pci-aspm.h, so remove
> the unnecessary include of it.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Looks good to me and feel free to take via your tree.

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
Kalle Valo
