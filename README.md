# AEErrorCell #
## Display errors with one line of code ##

If you're using a `UITableView` to display data, you probably need a way to
handle errors non-invasively (that is, without throwing an alert into the
user's face). After tiring of creating a custom cell for each time I ran into 
this problem, I created `AEErrorCell`, a reusable class to display an error
in a `UITableViewCell`.

## How to use it ##

From `tableView:cellForRowAtIndexPath:`, return a cell like this:

    return [AEErrorCell errorCellWithStyle:AEErrorCellStyleSimple
                                     error:error];

From `tableView:heightForRowAtIndexPath:`, return the height:

    return [AEErrorCell rowHeightForStyle:AEErrorCellStyleSimple];

## What do I get? ##

A cell displaying the `[NSError localizedDescription]` property in bold text, 
and the `localizedRecoverySuggestion` property in smaller gray type (if it is
non-nil).

## Getting a Retry button ##

You can also use `AEErrorCellStyleRetryButton`, in which case the cell will
display a simple "retry" button. You can access the button using the 
`retryButton` property; you probably want to add an action to the button like
this:

    [[errorCell retryButton] addTarget:self 
                                action:@selector(retry) 
                      forControlEvents:UIControlEventTouchUpInside];

## That's all folks... ##

That's all it does (really). BSD Licensed so you can use it as you like.
Suggestions for improvement (and pull requests) welcome!
