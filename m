From: alexandre.ferrieux@orange.com <alexandre.ferrieux@orange.com>
Date: Tue, 2 Jul 2019 23:45:03 +0200
Subject: [Intel-wired-lan] Fix for i40e driver: mirroring SEID mixup
Message-ID: <18399_1562103891_5D1BD053_18399_181_1_5f6c18db-7ec3-98bc-489c-8fa1297e3b20@orange.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

The attached patch fixes the non-working mirroring feature in all recent 
versions of the i40e driver including the latest (2.9.21).

Simply put, using

  echo 'add 3' > /sys/class/net/eth10/device/sriov/1/ingress_mirror

fails because it passes down the AQ a 0x0260 command with the same SEID (that of 
VF 3) as both mirrored-from and mirrored-to VF.

This was reported to the sourceforge e1000 projet a few days ago as

  https://sourceforge.net/p/e1000/bugs/646/

but I'm following advice given there to send it to you for a "fast track" as the 
repro and diagnosis is trivial and fix already provided.

Hope this helps,

-Alex

_________________________________________________________________________________________________________________________

Ce message et ses pieces jointes peuvent contenir des informations confidentielles ou privilegiees et ne doivent donc
pas etre diffuses, exploites ou copies sans autorisation. Si vous avez recu ce message par erreur, veuillez le signaler
a l'expediteur et le detruire ainsi que les pieces jointes. Les messages electroniques etant susceptibles d'alteration,
Orange decline toute responsabilite si ce message a ete altere, deforme ou falsifie. Merci.

This message and its attachments may contain confidential or privileged information that may be protected by law;
they should not be distributed, used or copied without authorisation.
If you have received this email in error, please notify the sender and delete this message and its attachments.
As emails may be altered, Orange is not liable for messages that have been modified, changed or falsified.
Thank you.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: alex-mirror.patch
Type: text/x-patch
Size: 762 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190702/3fd68bbc/attachment-0001.bin>
