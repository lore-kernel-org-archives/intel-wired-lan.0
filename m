From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 6 Feb 2018 13:06:53 -0800
Subject: [Intel-wired-lan] [PATCH] igb: Fix a test with HWTSTAMP_TX_ON
In-Reply-To: <20180206194759.26991-1-christophe.jaillet@wanadoo.fr>
References: <20180206194759.26991-1-christophe.jaillet@wanadoo.fr>
Message-ID: <20180206210653.qjqmbxyqsdw43t3w@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Feb 06, 2018 at 08:47:59PM +0100, Christophe JAILLET wrote:
> 'HWTSTAMP_TX_ON' should be handled as a value, not as a bit mask.
> The modified code should behave the same, because HWTSTAMP_TX_ON is 1
> and no other possible values of 'tx_type' would match the test.
> However, this is more future-proof, should other values be allowed one day.

Nice catch, and I am going to introduce more tx_type values soon.

Thanks,
Richard
