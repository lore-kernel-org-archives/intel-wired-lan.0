From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Mon, 5 Jun 2017 17:34:18 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: pci_set_drvdata must be called
 before register_netdev
In-Reply-To: <12c75353-174a-d6de-27bc-83cebba68c13@suse.com>
References: <12c75353-174a-d6de-27bc-83cebba68c13@suse.com>
Message-ID: <87618083B2453E4A8714035B62D67992A9000D21@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Jeff Mahoney [mailto:jeffm at suse.com]
>Sent: Saturday, June 03, 2017 3:01 PM
>To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org
>Cc: Tantilov, Emil S <emil.s.tantilov@intel.com>
>Subject: [PATCH] ixgbe: pci_set_drvdata must be called before register_netdev
>
>We call pci_set_drvdata immediately after calling register_netdev,
>which leaves a window where tasks writing to the sriov_numvfs sysfs
>attribute can sneak in and crash the kernel.  register_netdev cleans
>up after itself so placing pci_set_drvdata immediately before it
>should preserve the intent of commit 0fb6a55cc31f (ixgbe: fix crash
>on rmmod after probe fail).

This change should be OK for ixgbe, although there is an effort to avoid
the race between setting SRIOV and the probe in drivers by using the driver
lock: http://marc.info/?l=linux-kernel&m=149549349112592

Thanks,
Emil

