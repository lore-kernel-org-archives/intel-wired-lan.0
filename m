From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 31 Aug 2017 18:06:29 -0700
Subject: [Intel-wired-lan] [PATCH 31/31] timer: Switch to testing for
	.function instead of .data
In-Reply-To: <CAGXu5jK84cN9MdjfzaipD7GN8a37JMfD8X0Em4mk2_aFGuaOUg@mail.gmail.com>
References: <1504222183-61202-1-git-send-email-keescook@chromium.org>
 <1504222183-61202-32-git-send-email-keescook@chromium.org>
 <CAKdAkRTSgs+JTKRa2nvcSPD+zQ5OhsLx_aM8WaZyg304QQN3hA@mail.gmail.com>
 <CAGXu5jK84cN9MdjfzaipD7GN8a37JMfD8X0Em4mk2_aFGuaOUg@mail.gmail.com>
Message-ID: <CAKdAkRTS+L-A1K4ivvNKTN8wmkDxFtsnyd9KsKohyRLsfPxQgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Aug 31, 2017 at 4:59 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Aug 31, 2017 at 4:45 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
>> On Thu, Aug 31, 2017 at 4:29 PM, Kees Cook <keescook@chromium.org> wrote:
>>> In several places, .data is checked for initialization to gate early
>>> calls to del_timer_sync(). Checking for .function is equally valid, so
>>> switch to this in all callers.
>>
>> Not seeing the rest of patches it is unclear from the patch
>> description why this is needed/wanted.
>
> The CC list would have been really giant, but here is the first patch
> and the earlier series list:
>
> https://lkml.org/lkml/2017/8/31/904
> https://lkml.org/lkml/2017/8/30/760
>
> tl;dr: We're going to switch all struct timer_list callbacks to get
> the timer pointer as the argument instead of from the .data field.
> This patch is one step in removing open-coded users of the .data
> field.
>

And that is exactly what should have been in the patch description.

FWIW for input bits:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
