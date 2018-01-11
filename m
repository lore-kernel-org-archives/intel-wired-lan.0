From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 11 Jan 2018 22:54:12 +0000
Subject: [Intel-wired-lan] [PATCH] igb: Clear TXSTMP when ptp_tx_work()
 is timeout
In-Reply-To: <1514853198-14008-1-git-send-email-daniel.hua@ni.com>
References: <CAKgT0Ud8-6bf07niVk+bBk1SCPm1Bvd28NFhWoHAbA2Dh_Bfrw@mail.gmail.com>
 <1514853198-14008-1-git-send-email-daniel.hua@ni.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7377E4@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Daniel Hua
> Sent: Monday, January 1, 2018 4:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Daniel Hua <daniel.hua@ni.com>
> Subject: [Intel-wired-lan] [PATCH] igb: Clear TXSTMP when ptp_tx_work() is
> timeout
> 
> Problem description:
> After ethernet cable connect and disconnect for several iterations on a
> device with i210, tx timestamp will stop being put into the socket.
> 
> Steps to reproduce:
> 1. Setup a device with i210 and wire it to a 802.1AS capable switch (
> Extreme Networks Summit x440 is used in our case)
> 2. Have the gptp daemon running on the device and make sure it is synced
> with the switch
> 3. Have the switch disable and enable the port, wait for the device gets
> resynced with the switch
> 4. Iterates step 3 until the device is not albe to get resynced
> 5. Review the log in dmesg and you will see warning message "igb : clearing
> Tx timestamp hang"
> 
> Root cause:
> If ptp_tx_work() gets scheduled just before the port gets disabled, a LINK
> DOWN event will be processed before ptp_tx_work(), which may cause
> timeout
> in ptp_tx_work(). In the timeout logic, the TSYNCTXCTL's TXTT bit (Transmit
> timestamp valid bit) is not cleared, causing no new timestamp loaded to
> TXSTMP register. Consequently therefore, no new interrupt is triggerred by
> TSICR.TXTS bit and no more Tx timestamp send to the socket.
> 
> Signed-off-by: Daniel Hua <daniel.hua@ni.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

I do not have an 802.1AS switch at the moment but have been able to check this with Linux ptp on systems both back to back and in a switched environment.  I have several Extreme X460s in the test setup and have an Extreme AVB Feature Pack license on order to activate the gptp on the switch.  I will revisit this when the license arrives, but it is working fine for me from a regression perspective and I don't want to hold the patch up any longer due to lack of the license.  So...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
