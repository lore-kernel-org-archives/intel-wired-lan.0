From: Finn Thain <fthain@telegraphics.com.au>
Date: Wed, 25 Nov 2020 10:53:13 +1100 (AEDT)
Subject: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for
 Clang
In-Reply-To: <CANiq72nUt57u5DG9rH=DB0DzQH7U6-QbG-2Ou+PyCY=p=_Ggag@mail.gmail.com>
References: <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
 <ca071decb87cc7e905411423c05a48f9fd2f58d7.camel@perches.com>
 <0147972a72bc13f3629de8a32dee6f1f308994b5.camel@HansenPartnership.com>
 <d8d1e9add08cdd4158405e77762d4946037208f8.camel@perches.com>
 <dbd2cb703ed9eefa7dde9281ea26ab0f7acc8afe.camel@HansenPartnership.com>
 <20201123130348.GA3119@embeddedor>
 <8f5611bb015e044fa1c0a48147293923c2d904e4.camel@HansenPartnership.com>
 <202011241327.BB28F12F6@keescook>
 <alpine.LNX.2.23.453.2011250859290.15@nippy.intranet>
 <CANiq72nUt57u5DG9rH=DB0DzQH7U6-QbG-2Ou+PyCY=p=_Ggag@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2011251022550.14@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On Wed, 25 Nov 2020, Miguel Ojeda wrote:

> 
> The C standard has nothing to do with this. We use compiler extensions 
> of several kinds, for many years. Even discounting those extensions, the 
> kernel is not even conforming to C due to e.g. strict aliasing. I am not 
> sure what you are trying to argue here.
> 

I'm saying that supporting the official language spec makes more sense 
than attempting to support a multitude of divergent interpretations of the 
spec (i.e. gcc, clang, coverity etc.)

I'm also saying that the reason why we use -std=gnu89 is that existing 
code was written in that language, not in ad hoc languages comprised of 
collections of extensions that change with every release.

> But, since you insist: yes, the `fallthrough` attribute is in the 
> current C2x draft.
> 

Thank you for checking. I found a free version that's only 6 weeks old:

http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2583.pdf

It will be interesting to see whether 6.7.11.5 changes once the various 
implementations reach agreement.
