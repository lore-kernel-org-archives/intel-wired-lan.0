From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 31 May 2017 08:10:45 +0200
Subject: [Intel-wired-lan] [PULL] topic/e1000e-fix
In-Reply-To: <CAKMK7uF-b1U7qipgEoYnAjDtrNdvKYT4KkoV2=krikkdGERkCw@mail.gmail.com>
References: <20170530201542.a5rudn6xfykbj3la@phenom.ffwll.local>
 <20170530.181022.1101254623191993046.davem@davemloft.net>
 <CAPM=9twH-CXm+xj2Os87Ra7nOBQ+WNXYGF83wFqpQ3s=MNx_mQ@mail.gmail.com>
 <CAKMK7uF-b1U7qipgEoYnAjDtrNdvKYT4KkoV2=krikkdGERkCw@mail.gmail.com>
Message-ID: <CAKMK7uGbi2Bwfno9XogKZ-LUOyMepbtRyGuGrNYWwj6Cts+uag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, May 31, 2017 at 7:54 AM, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> On Wed, May 31, 2017 at 1:06 AM, Dave Airlie <airlied@gmail.com> wrote:
>> On 31 May 2017 at 08:10, David Miller <davem@davemloft.net> wrote:
>>> From: Daniel Vetter <daniel.vetter@ffwll.ch>
>>> Date: Tue, 30 May 2017 22:15:42 +0200
>>>
>>>> If the e1000e maintainer wants to coalesce or not return statements
>>>> this simple way, that's imo on him to change the color as needed.
>>>
>>> That's not how things work.
>>>
>>> If the maintainer wants you to style things a certain way, either you
>>> do it that way or your patch isn't accepted.
>
> Consider this pull a regression report, pls handle it.

And I guess I pile of more cc, to make this regression report
complete. I mean you got the backtrace, bisect and a proposed fix, and
the almost-whitespace change demanded is something gcc does in its
sleep. I'd understand a request to retest if it would be a real
functional change, but in this situation I have no idea why this
regression just can't be fixed already.

Not sure if it's really preferred if regression reports come
incomplete, without bugfix and bisect attached.
-Daniel

>> I'm not really sure why Chris just couldn't respin already.
>>
>> Though really I think Chris should have just asked for a revert of the
>> original patch that broke stuff, instead of trying to patch a driver
>> if he doesn't have time to get the patch right for the maintainer.
>
> Ok, can we pls revert 2800209994f8 ("e1000e: Refactor PM flows") then?
>
> Thanks, Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
