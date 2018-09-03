From: Marco Berizzi <pupilla@libero.it>
Date: Mon, 3 Sep 2018 12:09:50 +0200 (CEST)
Subject: [Intel-wired-lan] igb Detected Tx Unit Hang after upgrade to
 4.18-rc6 [was Re: igb Detected Tx Unit Hang after upgrade to 4.17]
In-Reply-To: <CAKgT0UcKxnUK-5E-hr+DHLMAXQtzad21XNuoskh5k8O0Nia7PA@mail.gmail.com>
References: <528200032.321946.1528186357567@mail.libero.it>
 <963322856.1365958.1530796944033@mail.libero.it>
 <931347915.758706.1532606173777@mail.libero.it>
 <CAKgT0UdmzKG6usaHqFt2N4q1FVX-8r58hbhWb9dc8ygS2UmKWQ@mail.gmail.com>
 <1265852288.743881.1532617415845@mail.libero.it>
 <CAKgT0Ud3CMQBKabty07ordkeDPoaaWK3_q3rMoAh7XMSJMSE9g@mail.gmail.com>
 <1312873949.790150.1532681266921@mail.libero.it>
 <117857591.886490.1532956286262@mail.libero.it>
 <403709248.209641.1533555587417@mail.libero.it>
 <978998680.826474.1535469615050@mail.libero.it>
 <CAKgT0Ueo7by0AuVocZiieZuv=ZhL9_FSP8R8yXndZwU1+eV-Mg@mail.gmail.com>
 <231579625.943257.1535706026202@mail.libero.it>
 <CAKgT0UcKxnUK-5E-hr+DHLMAXQtzad21XNuoskh5k8O0Nia7PA@mail.gmail.com>
Message-ID: <1538491676.1055857.1535969390637@mail.libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Il 1 settembre 2018 alle 4.01 Alexander Duyck <alexander.duyck@gmail.com> ha scritto:

> However with that being said it does occur to me that you mentioned
> using VirtualBox. I dug back through the dmesg output and found the
> line:
> [   20.944982] VBoxNetFlt: attached to 'eth0' / 00:19:99:ab:0b:38
> 
> I think there may be an issue with the filter stripping out packets at
> the end of a queue and as a result we are receiving packets with
> xmit_more set and not updating tail. At least that is my understanding
> of things for now as I am not that familiar with the VBoxNetFlt
> driver.
> 
> There are two ways to verify if this is the case. The first and more
> correct solution might be to look at updating
> vboxNetFltLinuxStartXmitFilter so that it will clear the xmit_more bit
> before handing it off to the lower device. If you don't have access to
> that an alternative would be to just modify the igb driver you have so
> that you replace "skb->xmit_more" with "true" and just force the tail
> to always be written out. It will cause a small performance hit but it
> will work around the issue in the driver that overwrote our network
> device ops.
> 
> Hope that helps.
> 
> - Alex

Thanks a lot Alexander for debugging this problem.
I'm confident the virtualbox people will take care
of this problem.

Thanks again for your prompt response.
