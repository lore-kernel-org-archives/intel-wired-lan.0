From: Arkady Gilinsky <arkady.gilinsky@harmonicinc.com>
Date: Sun, 27 Sep 2020 10:10:16 +0000
Subject: [Intel-wired-lan] i40e: Function i40e_set_max_tx_rate can exit
 without cleaning pending state
Message-ID: <fb7b00be5e73657deb6212a36a491d4f443165da.camel@harmonicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi All

The below patch fixing the erroneous state in driver (v2.12.6)
when function i40e_set_max_tx_rate exits without cleaning 
pending state of the device.

-- 
Best regards,
Arkady Gilinsky

------------------------------------------

-------------- next part --------------
A non-text attachment was scrubbed...
Name: fix-return-without-releasing-pending-state.patch
Type: text/x-patch
Size: 318 bytes
Desc: fix-return-without-releasing-pending-state.patch
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200927/87ab7754/attachment.bin>
