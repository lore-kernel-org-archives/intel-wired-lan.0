From: Malek, Patryk <patryk.malek@intel.com>
Date: Thu, 14 Jun 2018 09:14:57 +0000
Subject: [Intel-wired-lan] [PATCH net-queue] i40e: Fix incorrect skb
 reserved size on rx
In-Reply-To: <8963a38e-0583-1a3f-bcfe-8a62d5da6dbf@lab.ntt.co.jp>
References: <1528877310-2574-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
 <8ec63217-2aab-b240-ce95-530e5f1c1f15@iogearbox.net>
 <8963a38e-0583-1a3f-bcfe-8a62d5da6dbf@lab.ntt.co.jp>
Message-ID: <FA03331EB45A2544B0CBCB1A14B6429E2B2A3ED7@IRSMSX104.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> On 2018/06/13 18:06, Daniel Borkmann wrote:
> > On 06/13/2018 10:08 AM, Toshiaki Makita wrote:
> >> i40e_build_skb() reserves I40E_SKB_PAD + (xdp->data -
> >> xdp->data_hard_start) but obviously I40E_SKB_PAD is unnecessary
> here
> >> and mac_header/data feilds in skb becomes incorrect, and breaks

Shouldn't this be fields instead of feilds?

--
Patryk Ma?ek
--------------------------------------------------------------------

Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek
przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by
others is strictly prohibited.

