From: Daniel Hua <daniel.hua@ni.com>
Date: Thu, 28 Dec 2017 02:22:59 +0000
Subject: [Intel-wired-lan] [PATCH] Cover letter for igb: bug fix Tx
 interrupt is not
In-Reply-To: <CAKgT0UdHmP=bJuJPaUT15GdEBdzWr1unu==hj1CfoVvnG+uscg@mail.gmail.com>
References: <1514341064-8105-1-git-send-email-daniel.hua@ni.com>
 <CAKgT0UdHmP=bJuJPaUT15GdEBdzWr1unu==hj1CfoVvnG+uscg@mail.gmail.com>
Message-ID: <CY4PR04MB077709CECCB9E7671EAE9F42EB040@CY4PR04MB0777.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alex,

Thanks for the comments. I have put the description in the patch and resent it.

Regards,
-Daniel

-----Original Message-----
From: Alexander Duyck [mailto:alexander.duyck at gmail.com] 
Sent: Thursday, December 28, 2017 12:58 AM
To: Daniel Hua <daniel.hua@ni.com>
Cc: intel-wired-lan <intel-wired-lan@lists.osuosl.org>
Subject: Re: [Intel-wired-lan] [PATCH] Cover letter for igb: bug fix Tx interrupt is not

On Tue, Dec 26, 2017 at 6:17 PM, Daniel Hua <daniel.hua@ni.com> wrote:
> Problem description:
> After ethernet cable connect and disconnect for several iterations on 
> a device with i210, tx timestamp will stop being put into the socket.
>
> Steps to reproduce:
> 1. Setup a device with i210 and wire it to a 802.1AS capable switch ( 
> Extreme Networks Summit x440 is used in our case) 2. Have the gptp 
> daemon running on the device and make sure it is synced with the 
> switch 3. Have the switch disable and enable the port, wait for the 
> device gets resynced with the switch 4. Iterates step 3 until the 
> device is not albe to get resynced 5. Review the log in dmesg and you 
> will see warning message "igb : clearing Tx timestamp hang"
>
> Root cause:
> If ptp_tx_work() gets scheduled just before the port gets disabled, a 
> LINK DOWN event will be processed before ptp_tx_work(), which may 
> cause timeout in ptp_tx_work(). In the timeout logic, the TSYNCTXCTL's 
> TXTT bit (Transmit timestamp valid bit) is not cleared, causing no new 
> timestamp loaded to TXSTMP register. Consequently therefore, no new 
> interrupt is triggerred by TSICR.TXTS bit and no more Tx timestamp send to the socket.
>
> Daniel Hua (1):
>   igb: bug fix Tx interrupt is not triggered
>
>  drivers/net/ethernet/intel/igb/igb_ptp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> --

Could you please combine this description of the issue with the patch itself? It isn't really very useful to have the patch documented in a cover letter that will never make it into the driver itself.

Thanks.

- Alex
