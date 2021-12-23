From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 23 Dec 2021 12:03:20 -0800
Subject: [Intel-wired-lan] [PATCH net-next v2 0/4] igb: support PEROUT
 and EXTTS PTP pin functions on 82580/i354/i350
In-Reply-To: <20211028143459.903439-1-kernel.hbk@gmail.com>
References: <20211028143459.903439-1-kernel.hbk@gmail.com>
Message-ID: <20211223200320.GA29492@hoboy.vegasvil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Oct 28, 2021 at 04:34:55PM +0200, Ruud Bos wrote:

> The added EXTTS function has not been tested. However, looking at the data
> sheets, the layout of the registers involved match the i210 exactly except
> for the time registers mentioned before. Hence the almost identical
> implementation.
> 
> v2:
>  - fix PEROUT on SDP2/SDP3
>  - rename incorrectly named sdp function argument to tsintr_tt
>  - fix white space issue
> 
> Ruud Bos (4):
>   igb: move SDP config initialization to separate function
>   igb: move PEROUT and EXTTS isr logic to separate functions
>   igb: support PEROUT on 82580/i354/i350
>   igb: support EXTTS on 82580/i354/i350

For the series:

Acked-by: Richard Cochran <richardcochran@gmail.com>
