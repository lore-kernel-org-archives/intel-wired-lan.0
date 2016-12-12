From: Denny Page <dennypage@me.com>
Date: Mon, 12 Dec 2016 15:09:32 -0800
Subject: [Intel-wired-lan] Latency compensation for hardware timestamps
In-Reply-To: <05243125-DE22-414C-83CA-D73445F50CF6@me.com>
References: <05243125-DE22-414C-83CA-D73445F50CF6@me.com>
Message-ID: <9BD3C68A-4B46-4820-8804-7CBCE596D4E5@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[Apologies if I?m asking in the wrong place. If so, please redirect.]

I?ve been testing the i211 and i354, and it does appear that there should be latency compensation for these units similar to what is done for the i210. The i211 looks close to the i210, but the i354 looks quite a bit different.

Is there anyone that can offer information on appropriate compensation values for the i211 and i354?

Many thanks,
Denny



> On Dec 07, 2016, at 22:37, Denny Page <dennypage@me.com> wrote:
> 
> Hey gents,
> 
> Earlier in the year, there was a change introduced to the igb driver to compensate for for hardware timestamp latency in the Intel i210. The commit has this comment:
> 
>    Table 7-62 on page 338 of the i210 datasheet lists TX and RX latencies
>    for the various speeds the chip supports.  To give better ptp timestamp
>    accuracy, adjust the timestamps by the amounts Intel gives based on
>    current link speed.
> 
> And the values used were:
> 
>    IGB_I210_TX_LATENCY_10		9542
>    IGB_I210_TX_LATENCY_100		1024
>    IGB_I210_TX_LATENCY_1000	178
>    IGB_I210_RX_LATENCY_10		20662
>    IGB_I210_RX_LATENCY_100		2213
>    IGB_I210_RX_LATENCY_1000	448
> 
> I have been chasing an issue with timestamps on the i211 and i354, and it has led me to several questions related to this commit:
> 
> * In the current data sheet, table 7-62 offers values for 100Mb only. Are the compensation values for 10Mb and 1Gb still documented anywhere?
> 
> * The adjustment for the Tx timestamp at 100Mb (IGB_I210_TX_LATENCY_100) corresponds to the maximum latency value in table 7-62, but the adjustment for the Rx timestamp at 100Mb differs from the maximum value in table 7-62, 2213 vs 2133. Is this intentional?
> 
> * The data sheet for the i211 contains the same content regarding timestamps (table 7-59), with the same values for Tx/Rx latency, but the driver applies the compensation to the i210 only, with no compensation for the i211. Should compensation be applied to the i211 as well?
> 
> And one last tangent question:
> 
> * There is no compensation listed in the i350 data sheet, and no compensation in the driver. Does this mean that the i350/i354 requires no compensation?
> 
> Appreciate any thoughts you might have on this.
> 
> Thanks,
> Denny
> 
> ??
> 
> Refs:
> http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/i210-ethernet-controller-datasheet.pdf
> http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/i211-ethernet-controller-datasheet.pdf
> http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/ethernet-controller-i350-datasheet.pdf

