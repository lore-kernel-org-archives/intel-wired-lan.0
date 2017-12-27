From: Daniel Hua <daniel.hua@ni.com>
Date: Wed, 27 Dec 2017 10:17:43 +0800
Subject: [Intel-wired-lan] [PATCH] Cover letter for igb: bug fix Tx
 interrupt is not
Message-ID: <1514341064-8105-1-git-send-email-daniel.hua@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Problem description:
After ethernet cable connect and disconnect for several iterations on a
device with i210, tx timestamp will stop being put into the socket.

Steps to reproduce:
1. Setup a device with i210 and wire it to a 802.1AS capable switch (
Extreme Networks Summit x440 is used in our case)
2. Have the gptp daemon running on the device and make sure it is synced 
with the switch
3. Have the switch disable and enable the port, wait for the device gets
resynced with the switch
4. Iterates step 3 until the device is not albe to get resynced
5. Review the log in dmesg and you will see warning message "igb : clearing
Tx timestamp hang"

Root cause:
If ptp_tx_work() gets scheduled just before the port gets disabled, a LINK
DOWN event will be processed before ptp_tx_work(), which may cause timeout
in ptp_tx_work(). In the timeout logic, the TSYNCTXCTL's TXTT bit (Transmit
timestamp valid bit) is not cleared, causing no new timestamp loaded to
TXSTMP register. Consequently therefore, no new interrupt is triggerred by
TSICR.TXTS bit and no more Tx timestamp send to the socket.

Daniel Hua (1):
  igb: bug fix Tx interrupt is not triggered

 drivers/net/ethernet/intel/igb/igb_ptp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
1.9.1
