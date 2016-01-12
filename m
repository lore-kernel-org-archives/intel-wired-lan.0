From: Hisashi T Fujinaka <htodd@twofifty.com>
Date: Tue, 12 Jan 2016 15:13:38 -0800 (PST)
Subject: [Intel-wired-lan] [next PATCH 03/11] igb: Allow asymmetric
 configuration of MTU versus Rx frame size
In-Reply-To: <CAKgT0UdWEoxcs=J3c378ChNRZy8pfpXj0gq1cNiVv9o9GTvtBw@mail.gmail.com>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>
 <20160107071039.13648.55302.stgit@localhost.localdomain>
 <alpine.NEB.2.11.1601121001560.1772@chris.i8u.org>
 <CAKgT0UdWEoxcs=J3c378ChNRZy8pfpXj0gq1cNiVv9o9GTvtBw@mail.gmail.com>
Message-ID: <alpine.NEB.2.11.1601121512570.1772@chris.i8u.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 12 Jan 2016, Alexander Duyck wrote:

> On Tue, Jan 12, 2016 at 10:03 AM, Hisashi T Fujinaka <htodd@twofifty.com> wrote:
>> Hey Alex, I have a question.
>>
>> Aren't you writing a random pba here? Shouldn't it still be "pba = 0"  a
>> few lines up?
>
> If you take a look in the function there is a switch statement just
> above where pba is set to 34K for the 82575.  There are no cases in
> the switch statement where pba is not set.

Yeah, I need to get my eyes checked. Thanks!

-- 
Hisashi T Fujinaka - htodd at twofifty.com
BSEE + BSChem + BAEnglish + MSCS + $2.50 = coffee
