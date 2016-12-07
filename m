From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Date: Wed, 7 Dec 2016 20:24:50 +0100
Subject: [Intel-wired-lan] [PATCH 1/1] ixgbe: write flush vfta registers
In-Reply-To: <CAD=hENcE58xM4hBm-8N-eNREhBbP4gC-Vm89krQ6aj_8bDZmJg@mail.gmail.com>
References: <1479300041-3436-1-git-send-email-zyjzyj2000@gmail.com>
 <trinity-ec3a2e6f-7310-41aa-8743-61bc62ccf663-1479305144399@3capp-gmx-bs59>
 <CAD=hENfbWUobVvUOKhjRi+7fNCj=87R3GFeGjXg+zd_zez_SpQ@mail.gmail.com>
 <CAD=hENcE58xM4hBm-8N-eNREhBbP4gC-Vm89krQ6aj_8bDZmJg@mail.gmail.com>
Message-ID: <7c5c0227-04a1-fed9-9b56-4e2755f9a005@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Zhu,

On 07.12.2016 04:05, zhuyj wrote:
> After several week tests, your advice still make this bug appear. But
> my patch make this bug disappear.
> 
> Zhu Yanjun
> 

In your commit message you wrote
"Sometimes vfta registers can not be written successfully in dcb mode." 
Do you mean that the writes to the registers dont seem to have any effect at all? Or is the
effect only delayed? What exactly is your test case?

(BTW: please dont top-post).

Regards,
Lino
